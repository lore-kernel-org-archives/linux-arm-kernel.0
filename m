From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 23 Nov 2011 13:19:49 -0200
Subject: [PATCH v3 2/2] MEM2MEM: Add support for eMMa-PrP mem2mem
 operations.
In-Reply-To: <1322061227-6631-3-git-send-email-javier.martin@vista-silicon.com>
References: <1322061227-6631-1-git-send-email-javier.martin@vista-silicon.com>
 <1322061227-6631-3-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <CAOMZO5AEZZEYSMXtXwCw4Qx9sY5hzZmd7t7b4teROntskBmbVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Wed, Nov 23, 2011 at 1:13 PM, Javier Martin
<javier.martin@vista-silicon.com> wrote:
> Changes since v2:
> - Use devres to simplify error handling.
> - Remove unused structures.
> - Fix clock handling.
> - Other minor problems.

It would be better if you put such comments below the --- line.

For the commit message you can use the one you did for the cover
letter (0/2) patch:

"i.MX2x SoCs have a PrP which is capable of resizing and format
conversion of video frames. This driver provides support for
resizing and format conversion from YUYV to YUV420.

This operation is of the utmost importance since some of these
SoCs like i.MX27 include an H.264 video codec which only
accepts YUV420 as input."
