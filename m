From: xhpohanka@gmail.com (Jan Pohanka)
Date: Thu, 25 Aug 2011 14:35:16 +0200
Subject: dma buffers for camera
In-Reply-To: <Pine.LNX.4.64.1108242111560.14818@axis700.grange>
References: <op.v0p0hctkyxxkfz@localhost.localdomain>
	<Pine.LNX.4.64.1108242111560.14818@axis700.grange>
Message-ID: <op.v0rrw2nlyxxkfz@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

>
> The mx2_camera driver is allocating one "discard" buffer of the same  
> size,
> as regular buffers for cases, when the user is not fast enough to queue
> new buffers for the running capture. Arguably, this could be aliminated
> and the last submitted buffer could be re-used until either more buffers
> are available or the streaming is stopped. Otherwise, it could also be
> possible to stop capture until buffers are available again. In any case,
> this is the current driver implementation. As for 2 buffers instead of  
> one
> for the actual capture, I think, gstreamer defines 2 as a minimum number
> of buffers, which is actually also required for any streaming chance.
>

Thank you for clarification...

regards
Jan



-- 
Tato zpr?va byla vytvo?ena p?evratn?m po?tovn?m klientem Opery:  
http://www.opera.com/mail/
