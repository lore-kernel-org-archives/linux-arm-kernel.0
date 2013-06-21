From: xiechao.mail@gmail.com (Chao Xie)
Date: Fri, 21 Jun 2013 14:11:31 +0800
Subject: SCU registers mapping for CA9/CA5 cores
Message-ID: <CADApbei3QOCQRmo_oYZ_XiUVupq+4uUs7WNe6f7k_OG0LHB3=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi, Russell
When i sbumited the patch for pxa988 which is CA9, Arnd gave me some
suggestions of SCU mapping.
I used static mapping in the platform file for SCU registers mapping,
but Arnd think there should be a more general way to do it, and others
can benefit from it. I agree with him.

The following is his question for you when reply to my patch.
"Russell, do you think using a fixmap page for the SCU makes sense?
I'm looking for a method to consolidate the various methods of
doing early mappings of the SCU for device tree based platforms.
Where do you think that should be implemented?"

So can you give your idea and suggestion? Thanks.
