From: szemzo.andras@gmail.com (Andras Szemzo)
Date: Fri, 2 Sep 2016 16:29:42 +0200
Subject: irq_create_fwspec_mapping() in 4.8-rc2
In-Reply-To: <57C98975.5020607@arm.com>
References: <483F737F-9868-4E8A-A831-AA3F6F410AFF@gmail.com>
 <57C98975.5020607@arm.com>
Message-ID: <9FCA11A3-B677-42EA-80DB-674AC8E489E8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On 02 Sep 2016, at 16:15, Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
> So this is the interrupt that gets a mismatch.

Yes.

> Is there any other device in your system that uses the same interrupt?
> Where can I see your full DT file?

There is no other device using pioC 11.
Here is the DT:

http://pastebin.com/G7Z0hF5v
