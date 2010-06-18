From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 18 Jun 2010 22:28:50 +0800
Subject: Several questions regarding ARCH_S3C2410
In-Reply-To: <AANLkTinzTIxh06xDCcl34P5QhGS1nSHvrlmmQWWeISrW@mail.gmail.com>
References: <AANLkTimPk6mtyB57jXuAq1ugQseS655OCPEuP9-qZYoT@mail.gmail.com>
	<AANLkTilbEYR28lrVBAIXXuJ6sEf5uCp4Tpr7wriBZLj3@mail.gmail.com>
	<20100618090042.GY3498@trinity.fluff.org>
	<005d01cb0ed5$6bb83b90$4328b2b0$%kim@samsung.com>
	<AANLkTinzTIxh06xDCcl34P5QhGS1nSHvrlmmQWWeISrW@mail.gmail.com>
Message-ID: <AANLkTillhXSrUKpyOzg6zXA2DCwQmgQyNVH0bd4-lMcy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 18, 2010 at 10:21 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> Then how about to prepare the these activities.
>
> Next time we will use the s5pc210 (or whatever) and I hope to use it
> with s5pc110.

Better merge them into one, no more mach-* is recommended unless that's
inevitable.

> To to this how about to merge the s5p series?
>
> I suggest to read the OMAP mailing list how to support OMAP2, 3, and 4
> with single kernel.
>

Not necessary maybe. Just post your difficulties when merging them
into a single kernel and we can discuss.
