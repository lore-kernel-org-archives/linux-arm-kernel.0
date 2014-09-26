From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 26 Sep 2014 08:53:12 -0500
Subject: [PATCH 1/2] ARM: DT: apq8064: create
 qcom-apq8064-board-common.dtsi
In-Reply-To: <CAJAp7Ohdi2+M0LC+a3BT6++17b2DST8RgjJddKNEVwL9Ltqrdg@mail.gmail.com>
References: <1411718851-17436-1-git-send-email-mike.rapoport@gmail.com>
 <1411718851-17436-2-git-send-email-mike.rapoport@gmail.com>
 <CAJAp7Ohdi2+M0LC+a3BT6++17b2DST8RgjJddKNEVwL9Ltqrdg@mail.gmail.com>
Message-ID: <9BBA060F-07F6-44E8-B404-BFB553FBDE15@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 26, 2014, at 8:41 AM, Bjorn Andersson <bjorn@kryo.se> wrote:

> On Fri, Sep 26, 2014 at 1:07 AM, Mike Rapoport <mike.rapoport@gmail.com> wrote:
> 
> Cool to see the addition of dt for additional devices. I do however
> not think it is correct to put all these things in common?

I?m with Bjorn, just duplicate the settings for the cm-qs600 board in its .dts file.

- k
-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
