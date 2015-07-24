From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 24 Jul 2015 10:32:59 +0200
Subject: [PATCH v4 1/2] dt-bindings: regulator: mt6311: Add document for
 mt6311 regulator
In-Reply-To: <1437715481-31528-2-git-send-email-henryc.chen@mediatek.com>
References: <1437715481-31528-1-git-send-email-henryc.chen@mediatek.com>
 <1437715481-31528-2-git-send-email-henryc.chen@mediatek.com>
Message-ID: <CABxcv=kuUbDyzFR2bU7vcvvsqg_yQuqBn5S20=uaH9iBCL_xBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Henry,

I believe Mark asked you to use a subject lines reflecting the style
for the subsystem, so the subject should had been something like:

regulators: mt6311: Add DT binding document

On Fri, Jul 24, 2015 at 7:24 AM, Henry Chen <henryc.chen@mediatek.com> wrote:
> This patch adds a list of supported regulator names to the devicetree
> binding documentation for Mediatek MT6311 PMIC.
>
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---

I know is in your cover letter, but usually is good to also include a
history log of the changes for each patch so people know what changed.
Everything between the '---' and the diff are omitted by tools like
git am so you can add there.  You can use tools like patman that do
this automatically for you.

Also, I said that you could add my Reviewed-by after the node name
change so you should had carried that. So again:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
