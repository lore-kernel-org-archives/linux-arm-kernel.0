From: jteki@apm.com (Jagannadha Teki)
Date: Wed, 24 Dec 2014 17:17:14 +0530
Subject: ARM64 Crypto validation
In-Reply-To: <CAD6G_RRFU_R6SHvc5C785qtJ1GTt_-HXhn83xXOxc=VAwPjdqQ@mail.gmail.com>
References: <CAD6G_RRFU_R6SHvc5C785qtJ1GTt_-HXhn83xXOxc=VAwPjdqQ@mail.gmail.com>
Message-ID: <CA+ZZEcXCArW-6Fv9W=mLbEgQ_O2gMAwS1TLijovQPM+KU-3qeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Yazen Ghannam
+ Herbert Xu
+ Steve Capper

On Tue, Dec 23, 2014 at 3:45 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> Hi,
>
> I need some information to validate arm64/crypto, do we have any
> exact/defined way to validate this.
>
> Here are my findings:
> 1. I see a dirty test module tcrypto.c where we need to give the sec
> and mode module params as inputs.
> 2. Validate through open crypto [1]
>
> Do we have any arm64 specific validations, Request for help.
>
> [1] http://sourceforge.net/projects/ocf-linux/

thanks!
-- 
Jagan.
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information
that is confidential and proprietary to Applied Micro Circuits Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.
