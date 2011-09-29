From: gigin_jose@yahoo.co.in (GIGIN JOSE)
Date: Thu, 29 Sep 2011 14:11:03 +0000 (UTC)
Subject: YCbCr 422 on s3c2440
Message-ID: <loom.20110929T160147-550@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

I am working on s3c2440 ARM linux platform. I am connecting 
an image sensor device to the camera controller of the s3c2440 
ARM processor. The image sensor outputs YCbCr 4:2:2 output. 
Can I pass the output of this format to the preview path of 
the camera controller to get proper image ? 

The image sensor also outputs RGB565 format, which I can 
comfortably view using the preview path. But I would like 
to get the YCbCr 4:2:2 format from the image sensor device. 

Is this possible with the preview path ? Any other register
 settings are required for YCbCr 4:2:2 mode on the preview 
path, other than that done for the RGB565 format. ?

Thank You
GIGIN  
