From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 7 Oct 2015 14:02:11 +0300
Subject: [PATCH] ARM: shmobile: porter: add SDHI0/2 DT support
In-Reply-To: <20151007033957.GA30650@verge.net.au>
References: <2228837.DO5U5OvRSi@wasted.cogentembedded.com>
 <20151007033957.GA30650@verge.net.au>
Message-ID: <5614FBB3.5060806@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10/7/2015 6:39 AM, Simon Horman wrote:

>> Define the Porter board dependent part of the SDHI0/2 device nodes along with
>> the  necessary  voltage regulators (note that the Vcc regulators are dummy --
>> they are required but don't actually exist on the board). Also, GPIOs have to
>> be used for the CD and WP signals due to the SDHI driver constraints...
>>
>> This patch is analogous to the commit 1299df03d719 (ARM: shmobile: henninger:
>> add SDHI0/2 DT support) as there  are no differences between those boards in
>> this respect.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> This patch is against the 'renesas-devel-20151006-v4.3-rc4' tag of Simon
>> Horman's 'renesas.git' repo.
>
> Thanks I have queued this up after addressing some issues
> in the changelog that checkpatch complained about:
>
> * text > 75 characters wide
> * Missing '"' around name of patch referred to
>
> Its looking like there is already quite a log shared between

    Lot?

> r8a7791-porter.dts and r8a7791-henninger.dts. Do you have any
> thoughts on consolidating or sharing common elements between
> them somehow?

    I'm still planning to remove the Henninger's .dts for good. It was never 
sold and so had no users outside Renesas (and Cogent Embedded), I was told.

MBR, Sergei
