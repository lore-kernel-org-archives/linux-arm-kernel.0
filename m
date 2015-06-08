From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 08 Jun 2015 19:23:29 +0200
Subject: [PATCH 4/6] ARM: dts;
 pxa: add embedded pxa camera capture interface
In-Reply-To: <55736F05.8000904@cogentembedded.com> (Sergei Shtylyov's message
 of "Sun, 07 Jun 2015 01:07:01 +0300")
References: <1433624953-28165-1-git-send-email-robert.jarzmik@free.fr>
 <1433624953-28165-4-git-send-email-robert.jarzmik@free.fr>
 <55736F05.8000904@cogentembedded.com>
Message-ID: <877fre3yi6.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> writes:

>> +		pxa_camera: pxa_camera at 50000000 {
>
>    The ePAPR standard has something to say about the node naming:
> "The name of a node should be somewhat generic, reflecting the function of the
> device and not its precise programming model." So I'd suggest "video at 50000000"
> instead...
Okay, I understand. As "video" could stand for a video decoder/encoder, or the
display device, I'd rather go for "imaging" or "camera-host", or something like
that if I find an already used named in other dts files.

Cheers.

-- 
Robert
