From: vapier.adi@gmail.com (Mike Frysinger)
Date: Thu, 12 Aug 2010 08:47:06 -0400
Subject: [PATCH 1/2 v2] ARM: Fix gen_nand probe structures contents
In-Reply-To: <201008121304.01178.marek.vasut@gmail.com>
References: <1281581635-26213-1-git-send-email-marek.vasut@gmail.com>
	<AANLkTimuLjGo7O1kWXq0XbTns4EV2e5q5o0esNns1BY9@mail.gmail.com>
	<201008121304.01178.marek.vasut@gmail.com>
Message-ID: <AANLkTimuyuNGsTAfJXi7TL4HQH-botNcakse5NHj2fc0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 12, 2010 at 07:04, Marek Vasut wrote:
> Dne ?t 12. srpna 2010 05:36:31 Mike Frysinger napsal(a):
>> On Wed, Aug 11, 2010 at 22:53, Marek Vasut wrote:
>> > These three platforms didn't properly fill nr_chips in gen_nand
>> > registration and
>>
>> > therefore depended on gen_nand bug fixed by the following patch:
>> the Blackfin arch has a mailing list ... no need to pick out people
>
> Hi, that's true, but there's that "scripts/get_maintainer.pl" thing which gave
> me this list.

yes, but typically that's a shotgun approach that grabs way more
people and can easily fall out of date (people no longer
exist/etc...).  personally, i use it as a fallback when MAINTAINERS
doesnt cover it.
-mike
