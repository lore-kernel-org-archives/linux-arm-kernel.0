From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 21 Oct 2010 11:19:35 +0900
Subject: [PATCH 5/5] ARM: SAMSUNG: Add to enable/disable clock on S3C PL330
In-Reply-To: <AANLkTi=qmEHozO+1YtySkcmvr=QP973JtanQogqT82b4@mail.gmail.com>
References: <1287622713-1657-1-git-send-email-kgene.kim@samsung.com>
	<1287622713-1657-6-git-send-email-kgene.kim@samsung.com>
	<AANLkTi=ZTBuPBDL4MZ7MPn3Ha_cNhyShosyzn8q6QF3N@mail.gmail.com>
	<AANLkTimbHbO77POKuu=3XAO6Cq7UaAjJ291hwQqKTcNW@mail.gmail.com>
	<AANLkTinaDckVpJhadBcnhccdougyCG-FbXe23dh=_ep8@mail.gmail.com>
	<AANLkTinYHSUP5AspWbzD8hfKJtEaFAfcUYC0sOPy+WKX@mail.gmail.com>
	<AANLkTi=qmEHozO+1YtySkcmvr=QP973JtanQogqT82b4@mail.gmail.com>
Message-ID: <AANLkTi=Q+GQN9RP=aCZ-Uav3FfEg1dPT04n=jywWLqjF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 21, 2010 at 11:12 AM, Kyungmin Park <kmpark@infradead.org> wrote:

> BTW, what's the id of mdma and which clock at c210?

MDMA is not yet supported in Samsung mainline.
Any ID can be assigned as long as it doesn't conflict with other DMAs
and resources correctly attached to it.
