From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 17 Mar 2010 10:18:42 -0400
Subject: [PATCH 7/8] [ARM] pxa: move ssp into common plat-pxa
In-Reply-To: <f17812d71003170707g9290903ra98fa9f4d0942a86@mail.gmail.com>
References: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
	<771cded01003160549t73b30cccr7ba56722c28f013c@mail.gmail.com>
	<20100316125955.GB7287@rakim.wolfsonmicro.main>
	<f17812d71003160604q38846792i18efbcf9fb7208f@mail.gmail.com>
	<20100316132305.GA8875@rakim.wolfsonmicro.main>
	<f17812d71003160647v22569487k4f767da7dae6d298@mail.gmail.com>
	<20100316140834.GB9365@rakim.wolfsonmicro.main>
	<f17812d71003162214y10e98491v928b5c51d1bf2616@mail.gmail.com>
	<20100317100538.GC13166@opensource.wolfsonmicro.com>
	<f17812d71003170707g9290903ra98fa9f4d0942a86@mail.gmail.com>
Message-ID: <771cded01003170718n43553fc6sa5478892ba907929@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 17, 2010 at 10:07 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Wed, Mar 17, 2010 at 6:05 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Wed, Mar 17, 2010 at 01:14:39PM +0800, Eric Miao wrote:
>>
>>> I'm seeing no merge conflict between my ssp_cleanup and Takashi's
>>> latest tree, which branch do you suggest to merge then?
>>
>> I'm not sure what you're asking here but if you're looking for any
>> incompatible changes in ASoC they've not been implemented yet, the issue
>> is that due to the stuff Liam is working on at the minute there are
>> likely to be incompatible changes in the current release cycle which
>> would mean that merging new drivers (like Haojian posted) via a non-ALSA
>> tree would lead to problems after the trees are been merged together.
>>
>
> I tried a trivial merge of 'pxa-ssp' branch in your tree, and there's
> a conflict but it's fixable. There won't be much change to make in
> my 'ssp_cleanup' branch except for the pxa168 base support. What
> I can do is I'll try constantly merge of the asoc tree, and see if I can
> provide a conflict resolve which could be later used during upstream
> merge.
>

It seems not bad. How about you, Mark?

By the way, I reformat my patches on Eric's git since one of my patch
is contained in his branch (ssp_cleanup). Now I attach them for review first.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ssp_aspenite.tgz
Type: application/x-gzip
Size: 18666 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100317/835cdeb3/attachment-0001.tgz>
