From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 16 Feb 2011 13:55:19 -0800
Subject: [PATCH 2/2] ARM: remove the 4x expansion presumption while
	decompressing the kernel
In-Reply-To: <1297892343-29064-2-git-send-email-nico@fluxnic.net>
References: <1297892343-29064-1-git-send-email-nico@fluxnic.net>
	<1297892343-29064-2-git-send-email-nico@fluxnic.net>
Message-ID: <4D5C47C7.6010006@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/16/2011 01:39 PM, Nicolas Pitre wrote:
> -LDFLAGS_vmlinux := --defsym zreladdr=$(ZRELADDR)
> +LDFLAGS_vmlinux += --defsym zreladdr=$(ZRELADDR)

What is this for?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
