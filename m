From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 19 Apr 2016 13:52:54 +0300
Subject: [PATCH 1/2] mmc: core: Improve marking broken HPI through
 devicetree
In-Reply-To: <1461049934-12848-2-git-send-email-oliver@schinagl.nl>
References: <1461049934-12848-1-git-send-email-oliver@schinagl.nl>
 <1461049934-12848-2-git-send-email-oliver@schinagl.nl>
Message-ID: <57160E06.1000806@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 4/19/2016 10:12 AM, Olliver Schinagl wrote:

> In patch 81f8a7be66 Hans de Goede added a patch to allow marking an mmc

    scripts/checkpatch.pl now enforces certain commit citing style, the commit 
summary should be specified too.

> device as to having an broken HPI implementation. After talking some
> with Hans, we now think it is actually the mmc controller that can be
> broken and not support broken HPI's.
>
> This patch adds a new capability, mmc-broken-hpi, which allows us to
> mark a broken hpi implementation on the host level.
>
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
[...]

MBR, Sergei
