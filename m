From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 3 Jul 2014 10:25:01 +0300
Subject: [PATCHv5 05/15] hwspinlock/omap: add support for dt nodes
In-Reply-To: <53B460B4.9010200@ti.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com>
 <1398904476-26200-6-git-send-email-s-anna@ti.com>
 <CAK=WgbamDPN9EmKUu3+c3RbsQn1uhz5MGGvpWSSUJSUKyoH8Cw@mail.gmail.com>
 <53B460B4.9010200@ti.com>
Message-ID: <CAK=WgbZL9XbMtHpsQz8zuo5mbqSUnQhtjDoWPi2M2mfVxjaFNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 2, 2014 at 10:42 PM, Suman Anna <s-anna@ti.com> wrote:
> Yeah, I did this since we only had 1 instance, and used the same value
> as used in the non-DT legacy code. Once I fold back Patch 8 that adds
> the hwlock-base-id property, this will be assigned by reading that property.

Sounds good, thanks!
