From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Mon, 19 Oct 2009 18:41:13 +0200
Subject: [PATCH 5/6] mx31moboard: camera support
In-Reply-To: <Pine.LNX.4.64.0910162307160.26130@axis700.grange>
References: <1255599780-12948-1-git-send-email-valentin.longchamp@epfl.ch>	<1255599780-12948-2-git-send-email-valentin.longchamp@epfl.ch>	<1255599780-12948-3-git-send-email-valentin.longchamp@epfl.ch>	<1255599780-12948-4-git-send-email-valentin.longchamp@epfl.ch>	<1255599780-12948-5-git-send-email-valentin.longchamp@epfl.ch>	<1255599780-12948-6-git-send-email-valentin.longchamp@epfl.ch>
	<Pine.LNX.4.64.0910162307160.26130@axis700.grange>
Message-ID: <4ADC96A9.3090403@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

Guennadi Liakhovetski wrote:
> Hi
> 
> On Thu, 15 Oct 2009, Valentin Longchamp wrote:
> 
>> We have two mt9t031 cameras that have a muxed bus on the robot.
>> We can control which one we are using with gpio outputs. This
>> currently is not optimal
> 
> So, what prevents you from registering two platform devices for your two 
> cameras? Is there a problem with that?

The lack of time until now to do it properly. I sent those patches as 
initial RFC (and by the way thanks for your comment).

I would like to have one video interface only and that I can switch 
between the two physical camera using a quite simple system call. Would 
that be compatible with registering the two platform devices ?

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne
