From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 19 Jul 2017 15:14:55 +0200
Subject: [PATCH 1/2] arm64: syscallno is secretly an int, make it official
In-Reply-To: <1500381724-19003-2-git-send-email-Dave.Martin@arm.com>
References: <1500381724-19003-1-git-send-email-Dave.Martin@arm.com>
 <1500381724-19003-2-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170719151455.06d93ff4@karo-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 18 Jul 2017 13:41:43 +0100 Dave Martin wrote:
> The upper 32 bits of the syscallno field in struct pt_regs are handled
> inconsistently, being sometimes zero extended and sometimes
> sign-extended.  The reason for this appears to be that they are not
> intentionally significant at all.
> 
My english parser fails on "not intentionally significant at all".


Lothar Wa?mann
