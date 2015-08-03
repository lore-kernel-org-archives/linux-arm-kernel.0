From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 3 Aug 2015 13:32:20 -0400
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <24AFDCDB-55DE-4A23-A26A-750B48AC365C@gmail.com>
References: <12F47692-3010-4886-B87D-3D7820609177@gmail.com>
 <20150716113115.45a17f17@gandalf.local.home>
 <20150716121658.7982fdf5@gandalf.local.home>
 <20150717124054.GE26091@leverpostej>
 <20150717090009.720f6bd0@gandalf.local.home>
 <77EA0F10-D5F6-48BD-8652-3B979A978659@gmail.com>
 <20150717104144.6588b2f7@gandalf.local.home>
 <0886A996-40E1-49E9-823C-85E55A858716@gmail.com>
 <1357EA74-B972-4B99-ADB0-BC7E8F06DDB5@gmail.com>
 <20150720162004.GL9908@arm.com> <20150803090951.GA10501@arm.com>
 <D7BD8A9F-8710-42D5-A0ED-8747D2B6B268@gmail.com>
 <20150803125711.65463359@gandalf.local.home>
 <24AFDCDB-55DE-4A23-A26A-750B48AC365C@gmail.com>
Message-ID: <20150803133220.46db9839@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Aug 2015 02:22:16 +0900
Jungseok Lee <jungseoklee85@gmail.com> wrote:


> It would be better to add the snippet when a new version is ready.
> That way might help to figure out easily why the macro is introduced and how
> it can be used in architecture code.


OK, which ever.

-- Steve
