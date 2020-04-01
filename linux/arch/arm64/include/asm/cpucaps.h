/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * arch/arm64/include/asm/cpucaps.h
 *
 * Copyright (C) 2016 ARM Ltd.
 */
#ifndef __ASM_CPUCAPS_H
#define __ASM_CPUCAPS_H

#define ARM64_WORKAROUND_CLEAN_CACHE		0
#define ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE	1
#define ARM64_WORKAROUND_845719			2
#define ARM64_HAS_SYSREG_GIC_CPUIF		3
#define ARM64_HAS_PAN				4
#define ARM64_HAS_LSE_ATOMICS			5
#define ARM64_WORKAROUND_CAVIUM_23154		6
#define ARM64_WORKAROUND_834220			7
#define ARM64_HAS_NO_HW_PREFETCH		8
#define ARM64_HAS_UAO				9
#define ARM64_ALT_PAN_NOT_UAO			10
#define ARM64_HAS_VIRT_HOST_EXTN		11
#define ARM64_WORKAROUND_CAVIUM_27456		12
#define ARM64_HAS_32BIT_EL0			13
#define ARM64_HARDEN_EL2_VECTORS		14
#define ARM64_HAS_CNP				15
#define ARM64_HAS_NO_FPSIMD			16
#define ARM64_WORKAROUND_REPEAT_TLBI		17
#define ARM64_WORKAROUND_QCOM_FALKOR_E1003	18
#define ARM64_WORKAROUND_858921			19
#define ARM64_WORKAROUND_CAVIUM_30115		20
#define ARM64_HAS_DCPOP				21
#define ARM64_SVE				22
#define ARM64_UNMAP_KERNEL_AT_EL0		23
#define ARM64_HARDEN_BRANCH_PREDICTOR		24
#define ARM64_HAS_RAS_EXTN			25
#define ARM64_WORKAROUND_843419			26
#define ARM64_HAS_CACHE_IDC			27
#define ARM64_HAS_CACHE_DIC			28
#define ARM64_HW_DBM				29
#define ARM64_SSBD				30
#define ARM64_MISMATCHED_CACHE_TYPE		31
#define ARM64_HAS_STAGE2_FWB			32
#define ARM64_HAS_CRC32				33
#define ARM64_SSBS				34
#define ARM64_WORKAROUND_1418040		35
#define ARM64_HAS_SB				36
#define ARM64_WORKAROUND_SPECULATIVE_AT_VHE	37
#define ARM64_HAS_ADDRESS_AUTH_ARCH		38
#define ARM64_HAS_ADDRESS_AUTH_IMP_DEF		39
#define ARM64_HAS_GENERIC_AUTH_ARCH		40
#define ARM64_HAS_GENERIC_AUTH_IMP_DEF		41
#define ARM64_HAS_IRQ_PRIO_MASKING		42
#define ARM64_HAS_DCPODP			43
#define ARM64_WORKAROUND_1463225		44
#define ARM64_WORKAROUND_CAVIUM_TX2_219_TVM	45
#define ARM64_WORKAROUND_CAVIUM_TX2_219_PRFM	46
#define ARM64_WORKAROUND_1542419		47
#define ARM64_WORKAROUND_SPECULATIVE_AT_NVHE	48
#define ARM64_HAS_E0PD				49
#define ARM64_HAS_RNG				50

#define ARM64_NCAPS				51

#endif /* __ASM_CPUCAPS_H */
