From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 28 Nov 2017 22:52:43 +0100
Subject: [PATCH 3/4] ARM: pxa/spitz: Remove hardcoded partitioning,
 use sharpslpart parser
In-Reply-To: <CAAQYJAs4H=8nUkP2fXzxk=RYfCyQkVBu-JfeqQh7SRc0BSoH0Q@mail.gmail.com>
 (Andrea Adami's message of "Fri, 24 Nov 2017 13:52:22 +0100")
References: <1511300631-1343-1-git-send-email-andrea.adami@gmail.com>
 <1511300631-1343-3-git-send-email-andrea.adami@gmail.com>
 <20171122230633.GC3623@amd>
 <CAAQYJAs4H=8nUkP2fXzxk=RYfCyQkVBu-JfeqQh7SRc0BSoH0Q@mail.gmail.com>
Message-ID: <87efoi6pg4.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrea Adami <andrea.adami@gmail.com> writes:

> On Thu, Nov 23, 2017 at 12:06 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> On Tue 2017-11-21 22:43:50, Andrea Adami wrote:

Pavel, given that you didn't challenge Andrea's statement, I assume QEMU users
will switch to mtdparts again.

I'll apply the serie to pxa/for-next.

Cheers.

--
Robert
