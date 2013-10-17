From: bcm@fixthebug.org (Christian Daudt)
Date: Wed, 16 Oct 2013 23:12:57 -0700
Subject: [PATCH v3] ARM: bcm: Add DEBUG_LL console support
In-Reply-To: <1380987809-4886-1-git-send-email-bcm@fixthebug.org>
References: <1380987809-4886-1-git-send-email-bcm@fixthebug.org>
Message-ID: <CAEPRUYqnc0C_fEG97sFVs6uAtPyZCzXuJ09Hsb3unjAZtc5shA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 5, 2013 at 8:43 AM, Christian Daudt <bcm@fixthebug.org> wrote:
> This patch adds low level debug uart support to Broadcom
>  mobile based SOCs.
>
> Signed-off-by: Christian Daudt <bcm@fixthebug.org>
>
> Changes from V2:
>  - Changed to follow hex ordering on entries
>  - Dropped defconfig changes
>
> Changes from V1:
>  - Switched to use the common 8250 debug introduced in 3.12-rc1
>

Hi Russell,
 Does V3 look ok ?

 Thanks,
   csd
