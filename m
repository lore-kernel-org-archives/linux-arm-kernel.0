From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 29 Apr 2016 18:42:35 -0400
Subject: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
In-Reply-To: <20160429221606.GE19428@n2100.arm.linux.org.uk>
References: <20160429181248.GW19428@n2100.arm.linux.org.uk>
 <CAD=FV=VMxBYXOYOyHPeqcaWX7oU8pVrdLHOsWOWUgq-q5FshAw@mail.gmail.com>
 <20160429195741.GY19428@n2100.arm.linux.org.uk>
 <CAD=FV=UGyi0r3kDmc1cpcANTP-2u+7UEgW3r9kRvF2f8qcWH+g@mail.gmail.com>
 <20160429211328.GZ19428@n2100.arm.linux.org.uk>
 <CAD=FV=V8BOsO36eUOGAcXp04xCiN13UGG0Vaf2yhh1MQn85FjA@mail.gmail.com>
 <20160429212920.GA19428@n2100.arm.linux.org.uk>
 <CAD=FV=V9V8P=d59RX1eaAdVxJgMxub1F6hzQNw1QW+7t=3POBw@mail.gmail.com>
 <20160429215017.GC19428@n2100.arm.linux.org.uk>
 <CAD=FV=VgQX_EVhUUCugzv+CZqjzTS8LwyeU5419aX9FbDnWJDg@mail.gmail.com>
 <20160429221606.GE19428@n2100.arm.linux.org.uk>
Message-ID: <CABxcv==4C+RrEV1Fd+DkbMdGrLyObw36vsmo3wTGdxO=UnAa8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Fri, Apr 29, 2016 at 6:16 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 29, 2016 at 02:56:38PM -0700, Doug Anderson wrote:
>> Russell,
>>
>> On Fri, Apr 29, 2016 at 2:50 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Fri, Apr 29, 2016 at 02:39:35PM -0700, Doug Anderson wrote:
>> > [didn't read most of your reply]
>> >
>> >> Really I just reposted it several times because I notice that you seem
>> >> to ignore many points of my emails.  I was really hoping to get you to
>> >> address this point.  I notice that you still didn't.  Either you are
>> >> just trying to annoy me, or you don't have an answer to how my patch
>> >> series hurts you.
>> >
>> > I don't see you treating Rob with the same contempt that you have
>> > treated me in this thread, despite Rob and myself both telling you
>> > basically the same thing.
>>
>> Rob wrote a nice thoughtful reply and I tried to give a nice
>> thoughtful reply back to him.  He raised some good points and I raised
>> some good points back to him.  I look forward to his future thoughts
>> on the topic.
>
> Meanwhile, I've pointed out that you appear to be coming from a
> misunderstanding (that's certainly clear because you believed
> initially that grub did something it doesn't), showing that the
> "problem" you have is no different from the majority of other
> systems running Linux, and you treat me with contempt.
>
> What are you going to do to resolve this?
>

Maybe a third opinion could make this conversation constructive again.

I think Doug's point is that using a UUID or labels for consistency is
orthogonal to having a deterministic numbering for MMC devices. And I
agree with his point of view for what is worth.

I understand that this not true for other systems and peripherals but
in the specific case of MMC, the changes are minimal as Doug's patches
have shown and even the technical manual of SoCs has an enumeration to
refer each SD/MMC slot.

So I think is fair to say that SD/MMC is different than say USB mass
storage devices as you mentioned, and having a consistent numbering is
very helpful for diagnostics and debugging purposes IMHO.

BTW, I use labels in all my systems because as you said it's nice to
be able to swap cards and not change the bootloader env vars, but I
see how having a deterministic numbering could be useful to others.

Best regards,
Javier
