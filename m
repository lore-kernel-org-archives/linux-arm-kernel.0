From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Tue, 19 Dec 2017 15:43:09 +0200
Subject: [PATCH v9 2/2] media: i2c: Add the ov7740 image sensor driver
In-Reply-To: <CAOMZO5C5NJMffBEv2cdqKqUnTMQEYkqzN1JnJMS21PWtKuabnA@mail.gmail.com>
References: <20171211013146.2497-1-wenyou.yang@microchip.com>
 <20171211013146.2497-3-wenyou.yang@microchip.com>
 <20171219092246.3usg5mdyi27ivqlq@valkosipuli.retiisi.org.uk>
 <CAOMZO5BHSJv01SwZ2YNtGZTjMtOuOktET43qriK2fQ+jhE2TDA@mail.gmail.com>
 <20171219130537.2viv4wjcp4i3mdkj@valkosipuli.retiisi.org.uk>
 <CAOMZO5C5NJMffBEv2cdqKqUnTMQEYkqzN1JnJMS21PWtKuabnA@mail.gmail.com>
Message-ID: <20171219134308.4plzpknvksbzhio7@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 11:19:06AM -0200, Fabio Estevam wrote:
> Hi Sakari,
> 
> On Tue, Dec 19, 2017 at 11:05 AM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> 
> > I guess it depends on who do you ask and when. Looking at what has been
> > recently merged to media tree master, the latter is preferred.
> 
> Just did 'git grep SPDX drivers/media'
> 
> and it consistently shows // SPDX style for C files.

Both seem to exist. See e.g. c3a3d1d6b8b363a02234e5564692db3647f183e6 .

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi
