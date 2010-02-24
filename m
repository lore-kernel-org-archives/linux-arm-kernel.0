From: viresh.linux@gmail.com (viresh kumar)
Date: Wed, 24 Feb 2010 09:50:59 +0530
Subject: QUERY: Inclusion of header files in kernel header files.
In-Reply-To: <f17812d71002231852l1e47add7pc17764c67d26ae2b@mail.gmail.com>
References: <22dbbef21002222230x780c1ffatca5541453f6043ab@mail.gmail.com>
	<f17812d71002231852l1e47add7pc17764c67d26ae2b@mail.gmail.com>
Message-ID: <22dbbef21002232020k76d0f737tf24c8cba29679a21@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> My understanding is that if you are going to include every dependency
> into the header files, they are going to explode very soon. E.g. like bus.h,
> as long as you declared something like:
>
> struct device;
> struct resource;
>

If these two structure prototypes are already present in latest kernel
then its okay.
Actually i have seen 2.6.32 and these prototypes are not present
there, so we may need to add
header file or add prototypes of these structures.

rgds,
viresh.
