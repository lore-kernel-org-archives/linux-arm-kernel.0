From: digetx@gmail.com (Dmitry Osipenko)
Date: Thu, 5 Oct 2017 18:52:30 +0300
Subject: [PATCH 0/9] Bringing Asus TF300T support to mainline
In-Reply-To: <20171004212534.uosfz6757bbds2c5@qmqm.qmqm.pl>
References: <cover.1500510157.git.mirq-linux@rere.qmqm.pl>
 <20171004212534.uosfz6757bbds2c5@qmqm.qmqm.pl>
Message-ID: <dcbbc541-60c1-8af5-25ea-927629447a55@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.10.2017 00:25, Micha? Miros?aw wrote:
> On Thu, Jul 20, 2017 at 02:29:22AM +0200, Micha? Miros?aw wrote:
>> Here is a suprisingly small set of patches that enable Asus TF300T tablet
>> to boot and have all cores available. TF300T is one of a consumer devices
>> based on NVidia's Cardhu reference tablet.
>>
>> This series is an arch-dependent part. TF parts were extracted from ASUS's
>> GPL code dump.  The rest being driver code - a work in progress - is
>> available in branch tf300t at:
>>
>>         https://rere.qmqm.pl/git/linux
> 
> Just a quick note, that I've rebased the branch on v4.14-rc3 and added
> some more patches on top. This includes updated defconfig and devicetree
> with working eMMC and an attempt at making TF300T's dock hot-pluggable.
> 

Just a small note.. I think you should develop on top of linux-next, since your
patches would be applied to linux-next first.
