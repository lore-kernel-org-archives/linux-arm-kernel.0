From: eric@anholt.net (Eric Anholt)
Date: Fri, 14 Apr 2017 11:38:30 -0700
Subject: [PATCH v7 4/9] drm/stm: Add STM32 LTDC driver
In-Reply-To: <1492164819-10513-5-git-send-email-yannick.fertre@st.com>
References: <1492164819-10513-1-git-send-email-yannick.fertre@st.com>
 <1492164819-10513-5-git-send-email-yannick.fertre@st.com>
Message-ID: <87o9vyj0m1.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yannick Fertre <yannick.fertre@st.com> writes:

> This controller provides output signals to interface directly a variety
> of LCD and TFT panels. These output signals are: RGB signals
> (up to 24bpp), vertical & horizontal synchronisations, data enable and
> the pixel clock.
>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>

I squashed in one tiny fix for the new compiler warning due to *event
being unused in disable() now, applied Neil's review and my own, and
pushed patches 1-4.  Patches 5-9 will have to go through your arm-soc
trees for the platform.

Congrats!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170414/85c7fd3e/attachment.sig>
