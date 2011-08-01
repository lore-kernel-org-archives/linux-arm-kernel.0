From: lbassel@codeaurora.org (Larry Bassel)
Date: Mon, 1 Aug 2011 11:57:45 -0700
Subject: questions about memory hotplug
In-Reply-To: <20110729221230.GA3466@labbmf-linux.qualcomm.com>
References: <20110729221230.GA3466@labbmf-linux.qualcomm.com>
Message-ID: <20110801185745.GC3466@labbmf-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 Jul 11 15:12, Larry Bassel wrote:
> 
> Would CONFIG_ARCH_POPULATES_NODE_MAP help here? Does anyone
> use this? It doesn't seem to be in any defconfig or Kconfig

I want to clarify this, I meant used on ARM -- I see it is being used
on other architectures (and that movablecore= and kernelcore=
require this config option).

> on 3.0 (or earlier versions I've looked at).
> 

Larry

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
