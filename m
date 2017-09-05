From: cyndis@kapsi.fi (Mikko Perttunen)
Date: Tue, 5 Sep 2017 14:28:59 +0300
Subject: [PATCH v2 0/6] Host1x and VIC support for Tegra186
In-Reply-To: <20170905111031.u4damueklnuliqt4@phenom.ffwll.local>
References: <20170905084306.19318-1-mperttunen@nvidia.com>
 <20170905111031.u4damueklnuliqt4@phenom.ffwll.local>
Message-ID: <408624d4-9e69-661a-950f-b8d8386d6a27@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.09.2017 14:10, Daniel Vetter wrote:
>
> Since this is new hw support, is there also open source userspace using
> all this?

The VIC HW in Tegra186 is backwards compatible with the one in Tegra210, 
which has open userspace (https://github.com/cyndis/vaapi-tegra-driver), 
so that userspace should remain compatible. The old firmware is not 
compatible so we need a new compatibility string for that.

>
> Thanks, Daniel

Thanks,
Mikko
