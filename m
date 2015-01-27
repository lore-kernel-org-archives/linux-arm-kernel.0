From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 27 Jan 2015 16:58:17 -0500 (EST)
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <alpine.LFD.2.11.1501271614280.1322@knanqh.ubzr>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <20150127132127.GA869@amd>
 <CAL_JsqKM+2PtX_EpWXyOQHVXwf=jqVj8SroUGPO1Y2=Zj8_kMg@mail.gmail.com>
 <201501271532.25540@pali> <20150127174818.GM26493@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501271446330.1322@knanqh.ubzr>
 <20150127210943.GN26493@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501271614280.1322@knanqh.ubzr>
Message-ID: <alpine.LFD.2.11.1501271644570.1322@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Jan 2015, Nicolas Pitre wrote:

> If there is indeed a sizable following for the device then someone 
> should figure out how to cope with upstream kernels, either through the 
> installation of some intermediate bootloader that can talk FDT directly, 
> or via a shim layer.  None of that has to be performed by nor linked 
> with the kernel binary, nor maintained in the kernel tree. And it's not 
> even that hard to do: we have precedents on other platforms with crappy 
> bootloaders where this just works.

For reference I recommend the following threads:

http://comments.gmane.org/gmane.linux.kbuild.devel/10722

http://www.spinics.net/lists/arm-kernel/msg249719.html


Nicolas
