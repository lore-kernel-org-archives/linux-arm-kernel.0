From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 28 Jan 2015 16:41:44 +0300
Subject: [PATCH] ARM: shmobile: henninger: rename board to Porter
In-Reply-To: <CAMuHMdW3NmzGxGa9DOHpk4Evjg=+bduUPiMoRZT9Ko7+jNp-Nw@mail.gmail.com>
References: <2481726.lh33apx2TG@wasted.cogentembedded.com>
 <CAMuHMdW3NmzGxGa9DOHpk4Evjg=+bduUPiMoRZT9Ko7+jNp-Nw@mail.gmail.com>
Message-ID: <54C8E718.7060504@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 1/25/2015 10:30 PM, Geert Uytterhoeven wrote:

>> Renesas has made some changes to the Henninger low cost board hardware and at
>> the same time decided to  rename the board  to Porter.

> Which changes?

   I don't have a list ready, sorry. One thing I know is that HDMI chip is 
different (the same as on Koelsch now); we don't support it yet...

> They're not reflected in the new DTS?

    Not yet.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>> This patch is against 'renesas-devel-20150123-v3.19-rc5' tag of Simon Horman's
>> 'renesas.git' repo.
>>
>>   arch/arm/boot/dts/Makefile                                     |  2 +-
>>   .../arm/boot/dts/{r8a7791-henninger.dts => r8a7791-porter.dts} | 10 +++++-----
>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>   rename arch/arm/boot/dts/{r8a7791-henninger.dts => r8a7791-porter.dts} (96%)

> You forgot to update Documentation/devicetree/bindings/arm/shmobile.txt

    No wonder -- I had no idea it is listed there...

> Gr{oetje,eeting}s,

>                          Geert

WBR, Sergei
