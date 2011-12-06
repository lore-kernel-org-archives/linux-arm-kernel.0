From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Tue, 06 Dec 2011 23:39:47 +0100
Subject: [RFC PATCH v1 6/7] media: video: introduce face detection driver
 module
In-Reply-To: <4EDE90A3.7050900@gmail.com>
References: <1322838172-11149-1-git-send-email-ming.lei@canonical.com>	<1322838172-11149-7-git-send-email-ming.lei@canonical.com>	<4EDD3DEE.6060506@gmail.com>
 <CACVXFVPrAro=3t-wpbR_cVahzcx7SCa2J=s2nyyKfQ6SG-i0VQ@mail.gmail.com>
 <4EDE90A3.7050900@gmail.com>
Message-ID: <4EDE99B3.2010507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2011 11:01 PM, Sylwester Nawrocki wrote:
[...]
>
> It might be much better as the v4l2 events are associated with the frame
> sequence. And if we use controls then you get control events for free,
> and each event carries a frame sequence number int it
> (http://linuxtv.org/downloads/v4l-dvb-apis/vidioc-dqevent.html).

Oops, just ignore that. The frame sequence number is only available for
V4L2_EVENT_FRAME_SYNC events.
