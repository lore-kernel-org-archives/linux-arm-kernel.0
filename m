From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Tue, 10 Jul 2018 10:17:55 +0200
Subject: [PATCH v5 02/22] fixup! v4l2-ctrls: add
 v4l2_ctrl_request_hdl_find/put/ctrl_find functions
In-Reply-To: <5adf8a6aa70fd6f7f4326ccb068b66d6221d8d8b.camel@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-3-paul.kocialkowski@bootlin.com>
 <CAMuHMdVgJuK5G0+szV0BAWDBybxWV0iDWE5kZKuTdgNiGjpnEg@mail.gmail.com>
 <5adf8a6aa70fd6f7f4326ccb068b66d6221d8d8b.camel@bootlin.com>
Message-ID: <eb5fb671-4589-e0cf-5385-84a5cc912905@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/18 10:13, Paul Kocialkowski wrote:
> Hi,
> 
> On Tue, 2018-07-10 at 10:07 +0200, Geert Uytterhoeven wrote:
>> On Tue, Jul 10, 2018 at 10:02 AM Paul Kocialkowski
>> <paul.kocialkowski@bootlin.com> wrote:
>>> [PATCH v5 02/22] fixup! v4l2-ctrls: add v4l2_ctrl_request_hdl_find/put/ctrl_find functions
>>
>> git rebase -i ;-)
> 
> Although I should have mentionned it (and did not), this is totally
> intentional! The first patch (from Hans Verkuil) requires said fixup to
> work properly. I didn't want to squash that change into the commit to
> make the diff obvious.

Just squash the two for the next version you post.

> Ultimately, this framework patch is not really part of the series but is
> one of its underlying requirements, that should be merged separately (as
> part of the requests API series).

There is a good chance that this patch will go in via your series anyway
since it is not needed by vivid or vim2m.

Regards,

	Hans

> 
> I hope this clears up some of the confusion about this patch :)
> 
> Cheers!
> 
>> Gr{oetje,eeting}s,
>>
>>                         Geert
>>
