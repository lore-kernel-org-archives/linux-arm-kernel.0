From: rpurdie@rpsys.net (Richard Purdie)
Date: Thu, 22 Oct 2009 23:40:52 +0100
Subject: zaurus: cleanup sharpsl_pm.c
In-Reply-To: <20091022174816.GC5325@elf.ucw.cz>
References: <20091006200339.GA1538@ucw.cz> <20091017163627.GB1423@ucw.cz>
	<f17812d70910200859v6d18e81bs2760d8af1d8da5bf@mail.gmail.com>
	<f17812d70910220705o9f4a0ddwa22157b59a519350@mail.gmail.com>
	<20091022174816.GC5325@elf.ucw.cz>
Message-ID: <1256251252.23211.158.camel@dax.rpnet.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-10-22 at 19:48 +0200, Pavel Machek wrote:
> Introduce separate set of battery limits for corgi. This fixes
> compilation, and the values probably should be subtly different, too.

Corgi and spitz share the same batteries and charging circuits, its just
connected differently. This is why they shared the tables you've just
duplicated...

Cheers,

Richard


-- 
Richard Purdie
Intel Open Source Technology Centre
