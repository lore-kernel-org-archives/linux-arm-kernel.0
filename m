From: codekipper@gmail.com (Code Kipper)
Date: Sat, 12 Mar 2016 09:31:11 +0100
Subject: [linux-sunxi] Re: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM, Line
 and Mic inputs
In-Reply-To: <20160312085222.226d89bf@scratchpost.org>
References: <20151221123148.1ab6480b@dayas> <20151221123416.51aa938e@dayas>
 <20151227182157.GI30359@lukather> <20151228040649.475a742f@dayas>
 <20160106220908.GE9631@lukather> <20160109164832.515d69b0@dayas>
 <20160312085222.226d89bf@scratchpost.org>
Message-ID: <CAEKpxB=pKsEfMgGEh6KHZE-t+2tFxsyJkyDohS7OkmPCdNhoCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Danny,
I've got some patches to go which covers pretty much everything that
we can manage with the sun4i-codec. I'm only lacking testing of
certain bits as I don't have capable hardware(i.e. FM capture). I've
ignored the phone out part of the A20 as I couldn't find the pins.
I'll try to upload them to my github this weekend. You should have
authorship on some of these so when I send the link feel free to
claim.
BR,
CK

On 12 March 2016 at 08:52, Danny Milosavljevic <dannym@scratchpost.org> wrote:
> Hi,
>
> does anyone know the answer to the questions below?
>
>> The other direction (making two controls which both do the same and update
>> each other's value) doesn't seem to be easily available.
>
>> Should I write a _put handler that does it manually?
>
>> (Or should that be handled by alsa-lib mixer modules instead?)
>
>> Is it possible to merge the "Left Mixer" control and respective
>> "Right Mixer" control into one selem in alsamixer?
>>
>> Because alsamixer actually has support for one-sided muting.
>
> If that's unknown, I can post v9 without doing the grouping-together of mixer controls and we can use it like that - I don't want the patch to stall indefinitely on mere usability issues...
>
> Regards,
>     Danny
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
