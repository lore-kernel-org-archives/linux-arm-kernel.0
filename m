From: joe@perches.com (Joe Perches)
Date: Wed, 14 Jun 2017 11:59:34 -0700
Subject: [PATCH] Staging: vc04_services: bcm2835-audio: bcm2835-ctl.c:
 Fixed alignment to match open paranthesis.
In-Reply-To: <1497449172-3904-1-git-send-email-srishtishar@gmail.com>
References: <1497449172-3904-1-git-send-email-srishtishar@gmail.com>
Message-ID: <1497466774.18751.64.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-06-14 at 19:36 +0530, srishti sharma wrote:
> Fixed alignment so that it matched open paranthesis.

Please try to avoid typos in your commit message and as
well try to do all of alignment warnings in a single patch.

Ideally, all the files in a driver would be modified.

$ ./scripts/checkpatch.pl -f drivers/staging/vc04_services/bcm2835-audio/*.[ch]??--types=parenthesis_alignment --terse
drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:108: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:188: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:196: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:213: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:233: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:241: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:252: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:260: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:277: CHECK: Alignment should match open parenthesis
total: 0 errors, 0 warnings, 9 checks, 426 lines checked
drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:70: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:85: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:256: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:305: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:328: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:336: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:371: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:378: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:421: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:431: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:436: CHECK: Alignment should match open parenthesis
drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:525: CHECK: Alignment should match open parenthesis
total: 0 errors, 0 warnings, 12 checks, 567 lines checked
