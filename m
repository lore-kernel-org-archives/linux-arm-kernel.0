From: jassisinghbrar@gmail.com (jassi brar)
Date: Wed, 27 Jan 2010 19:37:12 +0900
Subject: [PATCHv2 01/10] ARM: S3C2443: GPIO: Correct AC97 pin defines
In-Reply-To: <20100127102946.GA13745@sirena.org.uk>
References: <1264571873-14924-1-git-send-email-jassisinghbrar@gmail.com>
	<20100127081140.GK9153@trinity.fluff.org>
	<1b68c6791001270015o4d5f42b8k858b959816c9b7c9@mail.gmail.com>
	<20100127102946.GA13745@sirena.org.uk>
Message-ID: <1b68c6791001270237w6e312ceck40e117a6dfc68d7a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 7:29 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jan 27, 2010 at 05:15:28PM +0900, jassi brar wrote:
>> On Wed, Jan 27, 2010 at 5:11 PM, Ben Dooks <ben-linux@fluff.org> wrote:
>> > On Wed, Jan 27, 2010 at 02:57:53PM +0900, jassisinghbrar at gmail.com wrote:
>> >> From: Jassi Brar <jassi.brar@samsung.com>
>> >>
>> >> GPIO_E-[5,9] pin functionality was defined incorrectly.
>> >> The patch corrects and adds missing pins.
>> >
>> > Ok, should I apply this to the fixes tree and send to linus?
>> Honestly speaking, I don't know. Please do as you see due.
>> Maybe Mark Brown, as an affected maintainer, has some opinion?
>
> Might've wanted to CC me there... :) ?If they're just plain wrong then
> it should probably go to Linus, though equally well nobody's been
> complaining about it.
yes, I missed to cc u on the first patch by mistake.
