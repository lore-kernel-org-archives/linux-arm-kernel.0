From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 4 Nov 2016 22:43:04 +0100
Subject: [PATCH v2 2/2] power: bq27xxx_battery: add poll interval
 property query
In-Reply-To: <CAKzfze_FrerJF6JOjVJ2XdyJgPm9OkEziX+oVOr7Aix3N31anw@mail.gmail.com>
References: <CAKzfze_rv29gwuBGctwTONyw8Oy6fwE+xcN0HMh-ZPB47HKzuQ@mail.gmail.com>
 <CAJ_EiSRzmQHLP2PTfzsLF4uWgYgCiRGsSk=MHbtOC5rgXnnFpw@mail.gmail.com>
 <20161031213846.GA21014@amd>
 <CAKzfze8Bom1XYRfiix_qYFckMggUD0eJm3Fz=GhNi6H_PBFyXA@mail.gmail.com>
 <20161102082206.GE21488@amd>
 <CAKzfze8d_MZJzR1a6rbwVXCWhb30C5GqFamUt2Viw1CzvyaQxw@mail.gmail.com>
 <20161104070955.GA3679@amd> <20161104145855.GH21430@atomide.com>
 <20161104202924.GA6841@amd>
 <CAKzfze_FrerJF6JOjVJ2XdyJgPm9OkEziX+oVOr7Aix3N31anw@mail.gmail.com>
Message-ID: <20161104214303.GA7938@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2016-11-04 13:39:19, Matt Ranostay wrote:
> On Fri, Nov 4, 2016 at 1:29 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > On Fri 2016-11-04 07:58:55, Tony Lindgren wrote:
> >> * Pavel Machek <pavel@ucw.cz> [161104 00:10]:
> >> > On Thu 2016-11-03 22:00:56, Matt Ranostay wrote:
> >> > Do you actually have hardware with more than one bq27xxx?
> >>
> >> I can at least see the twl4030 battery/charger features
> >> being used together with some bq device to monitor the
> >> battery state. Not sure if that counts as multiple
> >> instances here though :)
> >
> > I have that, too, but that was not what i was asking.
> >
> > Matt wanted support for different polling intervals on different
> > bq27xxx chips. I'd like to know know if he actually has more than one
> > bq27xxx in his device...
> >
> 
> Actually only one bq27xxx chip but in theory we could have more.

Hmm. As we'd have to keep both old and new interfaces to change the
polling interfaces. Lets not due that unless we really need to, ok?

Thanks,
		    	     	      	     	       	    	Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161104/f89a025b/attachment.sig>
