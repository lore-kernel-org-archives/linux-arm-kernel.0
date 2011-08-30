From: lacombar@gmail.com (Arnaud Lacombe)
Date: Tue, 30 Aug 2011 00:36:24 -0400
Subject: [RFC] Kbuild: allow code re-use across different directories
In-Reply-To: <alpine.LFD.2.00.1108300028470.20358@xanadu.home>
References: <1313800642-32418-1-git-send-email-lacombar@gmail.com>
	<CACqU3MVrSV-Qp7mC4iN_viMHz=2-cGPaqNY04eokYkVoE_pSuw@mail.gmail.com>
	<alpine.LFD.2.00.1108300028470.20358@xanadu.home>
Message-ID: <CACqU3MUaq7ZgM+7JpE-A_6FuH2zr+nA4+7u8rzVedLJfcyEcwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 30, 2011 at 12:32 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Mon, 29 Aug 2011, Arnaud Lacombe wrote:
>
>> On Fri, Aug 19, 2011 at 8:37 PM, Arnaud Lacombe <lacombar@gmail.com> wrote:
>> > With the attached patch, we would do:
>> >
>> > arch/foo/boot/Makefile:
>> > LDFLAGS_fancy.o := -DPANTS=30
>> > obj-y += fancy.o
>> > vpath-y += $(srctree)/arch/foo/lib
>> >
>> > and let GNU make do the job.
>> >
>> Nicolas, I guess you were the one who was interested for a generic way
>> to do such code re-use, did you had any chance to test the quoted
>> patch ?
>
> I actually missed the original post (I wasn't in CC) so I didn't test it.
> Will try to do so ASAP.
>
Sorry for the miss, I thought linux-arm-kernel@ would catch enough people :)

 - Arnaud
