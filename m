From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 26 May 2015 22:08:40 -0500
Subject: ARM64 kexec/kdump timeline
In-Reply-To: <1432239334.1922.7.camel@infradead.org>
References: <555E37FC.9020800@codeaurora.org>
 <1432239334.1922.7.camel@infradead.org>
Message-ID: <55653538.8020206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2015 03:15 PM, Geoff Levand wrote:
> I feel kexec was ready to merge nine months ago.  Users have only sent
> private e-mails like yourself, so there has been no public inquiries,
> and so, the arm64 maintainers think kexec is not of interest to users.

Does kexec on ARM64 support ACPI?  In some of our initial tests, it 
appears that the kexec'd kernel won't boot because it's expecting a 
device tree, and we don't have one.

ARM64 servers are supposed to use ACPI instead of a device tree.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
