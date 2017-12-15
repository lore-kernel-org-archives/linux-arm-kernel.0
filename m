From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 15 Dec 2017 11:56:02 +0100
Subject: [PATCH 3/4] ARM: pxa/spitz: Remove hardcoded partitioning, use
 sharpslpart parser
In-Reply-To: <87efoi6pg4.fsf@belgarion.home>
References: <1511300631-1343-1-git-send-email-andrea.adami@gmail.com>
 <1511300631-1343-3-git-send-email-andrea.adami@gmail.com>
 <20171122230633.GC3623@amd>
 <CAAQYJAs4H=8nUkP2fXzxk=RYfCyQkVBu-JfeqQh7SRc0BSoH0Q@mail.gmail.com>
 <87efoi6pg4.fsf@belgarion.home>
Message-ID: <20171215105602.GA12950@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2017-11-28 22:52:43, Robert Jarzmik wrote:
> Andrea Adami <andrea.adami@gmail.com> writes:
> 
> > On Thu, Nov 23, 2017 at 12:06 AM, Pavel Machek <pavel@ucw.cz> wrote:
> >> On Tue 2017-11-21 22:43:50, Andrea Adami wrote:
> 
> Pavel, given that you didn't challenge Andrea's statement, I assume QEMU users
> will switch to mtdparts again.
> 
> I'll apply the serie to pxa/for-next.

Well, I believe it is bad idea, but whatever. I still have zaurus, but
don't use it any more.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171215/b6293855/attachment.sig>
