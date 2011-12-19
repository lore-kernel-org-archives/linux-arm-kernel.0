From: veli-pekka.peltola@bluegiga.com (Veli-Pekka Peltola)
Date: Mon, 19 Dec 2011 13:18:12 +0200
Subject: [PATCH v3] ARM: mxs: Add initial support for Bluegiga APX4
 Development Kit
In-Reply-To: <20111219094428.GA5257@S2100-06.ap.freescale.net>
References: <1323766966-30502-1-git-send-email-lauri.hintsala@bluegiga.com>
 <20111219071350.GH4962@S2100-06.ap.freescale.net>
 <4EEEE40C.3000200@bluegiga.com>
 <20111219091916.GJ4962@S2100-06.ap.freescale.net>
 <20111219091322.GD14542@n2100.arm.linux.org.uk>
 <20111219091506.GA16097@n2100.arm.linux.org.uk>
 <20111219094428.GA5257@S2100-06.ap.freescale.net>
Message-ID: <4EEF1D74.8090009@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2011 11:44 AM, Shawn Guo wrote:
> On Mon, Dec 19, 2011 at 09:15:06AM +0000, Russell King - ARM Linux wrote:
>> On Mon, Dec 19, 2011 at 09:13:22AM +0000, Russell King - ARM Linux wrote:
>>> Someone needs to tell me what the correct entry is supposed to look like.
>>
> I guess it becomes MACH_TYPE_APX4DEVKIT now, but Lauri should be the
> 'someone' :)

I sent an email directly to Russell about the issue on 20.10.2011 but 
maybe it was wrong approach. It seems to be corrected now in the 
database. Thanks!

>> Also, whether Veli-Pekka Peltola is should still be the current owner
>> or whether there's someone more appropriate to be looking after this
>> entry (eg, the active platform maintainer) ?
>>
> Veli-Pekka Peltola still has SOB on the patch and he is on Cc, so he
> or Lauri may want to confirm.

It is ok to keep me as the owner. Some parts of machine support file is 
made by me and I have reviewed everything that has been sent to ML 
before Lauri sent those.

--
Veli-Pekka Peltola
