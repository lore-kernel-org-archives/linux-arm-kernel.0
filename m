From: srishtishar@gmail.com (srishti sharma)
Date: Thu, 15 Jun 2017 21:49:34 +0530
Subject: [PATCH] Staging: vc04_services: bcm2835-audio: bcm2835-ctl.c:
 Fixed alignment to match open paranthesis.
In-Reply-To: <1497466774.18751.64.camel@perches.com>
References: <1497449172-3904-1-git-send-email-srishtishar@gmail.com>
 <1497466774.18751.64.camel@perches.com>
Message-ID: <CAB3L5oxWBeN-YPWp94p7htH+D+ZpLomzVx2aMePMwApCPZiWUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 12:29 AM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2017-06-14 at 19:36 +0530, srishti sharma wrote:
>> Fixed alignment so that it matched open paranthesis.
>
> Please try to avoid typos in your commit message and as
> well try to do all of alignment warnings in a single patch.
>
> Ideally, all the files in a driver would be modified.
>
> $ ./scripts/checkpatch.pl -f drivers/staging/vc04_services/bcm2835-audio/*.[ch]  --types=parenthesis_alignment --terse
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:108: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:188: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:196: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:213: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:233: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:241: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:252: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:260: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:277: CHECK: Alignment should match open parenthesis
> total: 0 errors, 0 warnings, 9 checks, 426 lines checked
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:70: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:85: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:256: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:305: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:328: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:336: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:371: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:378: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:421: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:431: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:436: CHECK: Alignment should match open parenthesis
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:525: CHECK: Alignment should match open parenthesis
> total: 0 errors, 0 warnings, 12 checks, 567 lines checked
>
>


Hey,

Thanks for this , I have re-sent the patch .

Regards,
srishti
