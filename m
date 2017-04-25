From: nicolas@ndufresne.ca (Nicolas Dufresne)
Date: Tue, 25 Apr 2017 12:51:11 -0400
Subject: support autofocus / autogain in libv4l2
In-Reply-To: <20170425080815.GD30553@pali>
References: <1487074823-28274-1-git-send-email-sakari.ailus@linux.intel.com>
 <1487074823-28274-2-git-send-email-sakari.ailus@linux.intel.com>
 <20170414232332.63850d7b@vento.lan>
 <20170416091209.GB7456@valkosipuli.retiisi.org.uk>
 <20170419105118.72b8e284@vento.lan> <20170424093059.GA20427@amd>
 <20170424103802.00d3b554@vento.lan> <20170424212914.GA20780@amd>
 <20170424224724.5bb52382@vento.lan> <20170425080538.GA30380@amd>
 <20170425080815.GD30553@pali>
Message-ID: <1493139071.19105.14.camel@ndufresne.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mardi 25 avril 2017 ? 10:08 +0200, Pali Roh?r a ?crit?:
> On Tuesday 25 April 2017 10:05:38 Pavel Machek wrote:
> > > > It would be nice if more than one application could be
> > > > accessing the
> > > > camera at the same time... (I.e. something graphical running
> > > > preview
> > > > then using command line tool to grab a picture.) This one is
> > > > definitely not solveable inside a library...
> > > 
> > > Someone once suggested to have something like pulseaudio for V4L.
> > > For such usage, a server would be interesting. Yet, I would code
> > > it
> > > in a way that applications using libv4l will talk with such
> > > daemon
> > > in a transparent way.
> > 
> > Yes, we need something like pulseaudio for V4L. And yes, we should
> > make it transparent for applications using libv4l.
> 
> IIRC there is already some effort in writing such "video" server
> which
> would support accessing more application into webcam video, like
> pulseaudio server for accessing more applications to microphone
> input.
> 

Because references are nice:

https://blogs.gnome.org/uraeus/2015/06/30/introducing-pulse-video/
https://gstconf.ubicast.tv/videos/camera-sharing-and-sandboxing-with-pinos/

And why the internals are not going to be implemented using GStreamer in the end:
https://gstconf.ubicast.tv/videos/keep-calm-and-refactor-about-the-essence-of-gstreamer/

regards,
Nicolas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170425/c6b3f95c/attachment-0001.sig>
