From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 20 Dec 2012 23:29:59 +0200
Subject: [PATCH 3/9] mailbox: rename omap_mbox in mailbox
In-Reply-To: <1355836212-17956-4-git-send-email-loic.pallardy-ext@stericsson.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
 <1355836212-17956-4-git-send-email-loic.pallardy-ext@stericsson.com>
Message-ID: <CAK=WgbYOJA26PU7sg0ndB981WQEeiaQxSUVEJRACw1b7ogpiOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Loic,

On Tue, Dec 18, 2012 at 3:10 PM, Loic Pallardy
<loic.pallardy-ext@stericsson.com> wrote:
> In order to create a generic mailbox framework, functions
> and structures should be renamed in mailbox.

This patch should also update omap_remoteproc.c so the build doesn't
break (and if you have a panda board around it might be nice to run
the remoteproc sample to make sure things still generally work).

Thanks,
Ohad.
