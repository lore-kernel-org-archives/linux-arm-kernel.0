From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Mon, 23 Sep 2013 09:52:45 +0100
Subject: [PATCH] ARM: STi: Add cpu hotplug support
In-Reply-To: <20130923082926.GR12758@n2100.arm.linux.org.uk>
References: <1379924530-26319-1-git-send-email-srinivas.kandagatla@st.com>
 <20130923082926.GR12758@n2100.arm.linux.org.uk>
Message-ID: <5240015D.603@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/09/13 09:29, Russell King - ARM Linux wrote:
> On Mon, Sep 23, 2013 at 09:22:10AM +0100, Srinivas KANDAGATLA wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>>
>> This patch adds cpu hotplug support to STi series SoCs. This code is
>> cloned from arch/arm/mach-realview/hotplug.c.
>>
>> STiH415 and STiH416 SOCs do not have power control lines wired up to
>> each core, so all we can do is to put the core into WFI for hotplug
>> support.
> 
> Note that this means you can't support KEXEC on this platform.
> 
> 
Yes I understand, we cant support kexec with the existing code in v3.12-rc1.

Kexec support on platforms like this is the other topic I would like to
discuss.

Thanks,
srini
