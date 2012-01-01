From: robherring2@gmail.com (Rob Herring)
Date: Sun, 01 Jan 2012 09:22:23 -0600
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <CACRpkdbLMW-SXnr6hbpwMqG=-a0wmYtU+YnyR8uLsndUp=UBgQ@mail.gmail.com>
References: <1324402840-32451-1-git-send-email-b29396@freescale.com>
 <1324402840-32451-3-git-send-email-b29396@freescale.com>
 <CACRpkdbLMW-SXnr6hbpwMqG=-a0wmYtU+YnyR8uLsndUp=UBgQ@mail.gmail.com>
Message-ID: <4F007A2F.5010303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/01/2012 08:07 AM, Linus Walleij wrote:
> On Tue, Dec 20, 2011 at 6:40 PM, Dong Aisheng <b29396@freescale.com> wrote:
> 
>> From: Dong Aisheng <dong.aisheng@linaro.org>
>>
>> This patch provies a common API for driver to use to register pinmux
>> mappings from dts file. It is needed for dt support.
> 
> Overall I feel lost in this discussion due to limited exposure to
> device tree concepts. If I get Stephen Warrens and one of the
> DT people's (Rob, Grant) ACK on this I'll be happy to merge it.
> 
> Until then, I guess it will need to be refined for the next kernel
> cycle.

Yes. As Stephen has commented, this still needs a bit of work on the
binding.

Rob
