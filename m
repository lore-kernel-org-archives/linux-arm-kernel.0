From: alanbutty12@gmail.com (alan butler)
Date: Fri, 17 Aug 2012 13:47:06 +0100
Subject: Issues with all kernels after 3.3.7
Message-ID: <CADhrpJ7r4PPM2nOD7Wch9H+usaDUJ5XYeim6THUKEDTz=-Zyig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have been trying all kernels after 3.3.7 (except for the 3.5 series)
on my ix2-200
and have found that on every kernel 3.3.8, 3.4, 3.4.2, 3.4.4 =>3.4.7
and now even on 3.6 rc1
and the next dated today 17 august that when i use git for example:

git clone git://git.videolan.org/x264

my system just crash's / hangs and even through the serial port i get
no response.
This also happens when i try to access a web interface for example the
serviio java webui.

The second issue i have noticed is that my raid 0 array hangs / pauses
when being mounted
at system startup. (for approximatly 30 seconds maybe more maybe less
im not certain).
But again on the 3.3.7 kernel there was no issue and no hang.

If i return to 3.3.7 everything works fine with no other modifications
to the os or kernels.
I am using debian wheezy at the moment but also tried debian squeeze
so it does not
seem to be related to the specific linux version just the kernel.
