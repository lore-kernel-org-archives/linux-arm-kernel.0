From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 10 Nov 2009 10:39:12 +0100 (CET)
Subject: [PATCH 1/3 v2] ezx: Add camera support for A780 and A910 EZX
	phones
In-Reply-To: <20091110102950.497af1fb.ospite@studenti.unina.it>
References: <f17812d70911040119g6eb1f254pa78dd8519afef61d@mail.gmail.com>
	<1257367650-15056-1-git-send-email-ospite@studenti.unina.it>
	<Pine.LNX.4.64.0911050040160.4837@axis700.grange>
	<20091105234429.ef855e2d.ospite@studenti.unina.it>
	<Pine.LNX.4.64.0911061419220.4389@axis700.grange>
	<20091106182910.a3b48c41.ospite@studenti.unina.it>
	<20091110102950.497af1fb.ospite@studenti.unina.it>
Message-ID: <Pine.LNX.4.64.0911101037280.5074@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Nov 2009, Antonio Ospite wrote:

> Ping.
> 
> Guennadi, did you see the patch below? Or I should completely remove
> the .init() callback like you said in another message?
> As I said, my humble preference would be to keep GPIOs setup local to
> the driver somehow, but you just tell me what to do :)

Yes, please make GPIO config static and remove .init.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
