From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 14 Aug 2015 16:59:52 +0200
Subject: [PATCH v4 1/6] media: get rid of unused "extra_links" param on
 media_entity_init()
In-Reply-To: <b0b576e0bfcc043b4fdab3a57665b525fc054add.1439563682.git.mchehab@osg.samsung.com>
References: <cover.1439563682.git.mchehab@osg.samsung.com>
 <b0b576e0bfcc043b4fdab3a57665b525fc054add.1439563682.git.mchehab@osg.samsung.com>
Message-ID: <55CE0268.9050400@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2015 04:56 PM, Mauro Carvalho Chehab wrote:
> Currently, media_entity_init() creates an array with the links,
> allocated at init time. It provides a parameter (extra_links)
> that would allocate more links than the current needs, but this
> is not used by any driver.
> 
> As we want to be able to do dynamic link allocation/removal,
> we'll need to change the implementation of the links. So,
> before doing that, let's first remove that extra unused
> parameter, in order to cleanup the interface first.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Thanks!

	Hans
