From: arhuaco@freaks-unidos.net (Nelson Castillo)
Date: Wed, 2 Sep 2009 04:51:56 -0500
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090902031719.GK3838@prithivi.gnumonks.org>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
Message-ID: <2accc2ff0909020251u4f242742k13aa74f03251b992@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> * port existing s3c_ts driver to use s3c_adc_register()
> ** has anyone been doing wokr on this already? ben?

(jumping in)

I worked on this starting from some work done by other members of this
list. This is the ported version of the driver. It depends on the
touchscreen filters developed by Andy Green and enhanced by me while
working at Openmoko. I've already applied most of Andrew Morton's
feedback (a lot) to the TS filters but I haven't submitted them again
for upstream review (A filter still needs to be modified and I know
how to do it but I haven't finished this change).

http://nelson-patches.googlecode.com/svn/trunk/openmoko/kernel/ts-with-s3c-adc/s3c2410_ts.c
http://nelson-patches.googlecode.com/svn/trunk/openmoko/kernel/ts-with-s3c-adc/

One problem here is that we need to find a way to do this in a cleaner way:

http://nelson-patches.googlecode.com/svn/trunk/openmoko/kernel/ts-with-s3c-adc/s3c-adc-add-delay.patch

Nelson.-
