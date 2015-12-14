From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 14 Dec 2015 13:45:07 -0800
Subject: [PATCH/RFC 0/7] ARM: dts: Add compatible property to "partitions"
 node
In-Reply-To: <20151214214312.GA86857@google.com>
References: <1450120304-2760-1-git-send-email-geert+renesas@glider.be>
 <20151214194613.GA126731@google.com>
 <CAMuHMdW=wJEoi-+EWAKBjRwb+QFvk=iFur1yFqR=q0f4zwzb2Q@mail.gmail.com>
 <20151214214312.GA86857@google.com>
Message-ID: <CAN8TOE9O_egvFevRj3WaUcJd8GMFAAQcWLHMtKe1gwCR14zDPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ real linux-mtd mailing list

On Mon, Dec 14, 2015 at 1:43 PM, Brian Norris
<computersforpeace@gmail.com> wrote:
> On Mon, Dec 14, 2015 at 10:20:19PM +0100, Geert Uytterhoeven wrote:
>> On Mon, Dec 14, 2015 at 8:46 PM, Brian Norris
>> <computersforpeace@gmail.com> wrote:
>> > On Mon, Dec 14, 2015 at 08:11:37PM +0100, Geert Uytterhoeven wrote:
>> >> As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
>> >> property to "partitions" node"), the "partitions" subnode of an SPI
>> >> FLASH device node must have a compatible property. The partitions are no
>> >> longer detected if it is not present.
>> >
>> > For all patches:
>> >
>> > Acked-by: Brian Norris <computersforpeace@gmail.com>
>> >
>> >> I marked this series as "RFC", as the abovementioned commit is not yet
>> >> upstream. Ideally, the users should be fixed first, to avoid breakage.
>>
>> It breaks bisectability in mainline.
>
> The files you are fixing are not converted in mainline yet, are they?
>
>> > I'd differ on the last sentence. It's more important to straighten out
>> > the release features for 4.4 than to make sure that linux-next has
>> > perfect DTS files. So I'll submit whenever ready :)
>>
>> If the DTS changes go in first, bisectability is preserved.
>
> Are you asking me to delay fixing the DT binding until 4.5, just because
> your for-next branches can't be fixed? IOW, you want me to release the
> bad DT binding for a whole cycle?
>
> Brian
