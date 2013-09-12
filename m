From: olof@lixom.net (Olof Johansson)
Date: Thu, 12 Sep 2013 09:46:31 -0700
Subject: [PATCH] ARM: msm: Move msm devicetrees under a Qualcomm dir
In-Reply-To: <1379003839-16068-1-git-send-email-galak@codeaurora.org>
References: <1379003839-16068-1-git-send-email-galak@codeaurora.org>
Message-ID: <CAOesGMisWLwYKotGDFPW6PyHJs=_+fohTdC08SGjsv2FXaa7Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 9:37 AM, Kumar Gala <galak@codeaurora.org> wrote:
> Use the Qualcomm vendor prefix (qcom) as the directory name for
> Qualcomm MSM devicetrees going forward.
>
> Signed-off-by: Kumar Gala <galak@codeaurora.org>

Let's not move just one platform like this. If we are to do this, we
should move everything, and that will be really painful and needs to
be done in a controlled manner, probably scripted and right before a
-rc1 or such.


-Olof
