From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 23 Feb 2016 10:29:02 -0800
Subject: [PATCH v5 00/15] arm64: kernel: Add support for
 hibernate/suspend-to-disk
In-Reply-To: <1455637767-31561-1-git-send-email-james.morse@arm.com> (James
 Morse's message of "Tue, 16 Feb 2016 15:49:12 +0000")
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
Message-ID: <7h37sjuvpt.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

James Morse <james.morse@arm.com> writes:

> This version of hibernate is based on v4.5-rc4, with the contents of the arm64
> for-next/pgtable branch and Ard's v6sub1 "arm64: split linear and kernel
> mappings" series [0]. The patches shared with kexec still come from v13 [1].

FYI... in addition to juno-r2, I've now tested this version on the
Mediatek mt8173-evb platform as well, using an exteral MMC card as swap,
and everything worked well.

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin
