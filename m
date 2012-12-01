From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Sat, 1 Dec 2012 12:09:59 +0530
Subject: [PATCH] ARM: DTS: CROS5250: Add max77686 device tree support
In-Reply-To: <CAM4voakrpSJX6WWU5EMD-sUPqgjeOdph-R1KUBYJTEPDbr=wgA@mail.gmail.com>
References: <1354099900-24779-1-git-send-email-a.kesavan@samsung.com>
 <CAD=FV=Xfbt25-_JMENLiR+N+oC-vPkjxR8brbqYtt4ZFr-60kw@mail.gmail.com>
 <CAM4voakrpSJX6WWU5EMD-sUPqgjeOdph-R1KUBYJTEPDbr=wgA@mail.gmail.com>
Message-ID: <CAM4voam6fnAa-s7EgsmJgv4dYumzOv7W48BeT0vvn_i=j504nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[...]
>> This voltage doesn't match what Chrome OS has.  We have 1.0V.  Do you
>> have a specific reason for increasing?
> The default is 1.1V and the schematics I have shows 1.1V as well.
> Looks like the one in
> chrome os is incorrect.
Was checking the SMDK schemata, the snow one has it as 1.0V. Will fix.

Abhilash
