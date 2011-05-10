From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 10 May 2011 15:59:48 +0400
Subject: [PATCH] pxamci: remove an ifdef about CONFIG_REGULATOR
In-Reply-To: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
References: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
Message-ID: <4DC928B4.2040101@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10-05-2011 0:11, Antonio Ospite wrote:

> Don't wrap regulator_get() inside an #ifdef CONFIG_REGULATOR anymore, as
> now (since be1a50d)

    Need the summary of that commit cited too -- for the human readers.

> it correctly degenerates and returns NULL when the
> regulator framework is disabled.

> Signed-off-by: Antonio Ospite<ospite@studenti.unina.it>

WBR, Sergei
