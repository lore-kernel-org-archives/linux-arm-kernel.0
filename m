From: briannorris@chromium.org (Brian Norris)
Date: Tue, 7 Feb 2017 17:03:28 -0800
Subject: [PATCH 0/9] arm64: dts: rockchip: support Google Kevin
In-Reply-To: <1779025.vjYEOhejf3@phil>
References: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
 <1779025.vjYEOhejf3@phil>
Message-ID: <20170208010327.GA77920@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 02:01:42AM +0100, Heiko Stuebner wrote:
> Am Donnerstag, 1. Dezember 2016, 18:27:24 CET schrieb Brian Norris:
> > This series adds basic support for Google Kevin, a board in the Gru device
> > family. I do not add a leaf .dts board file for Gru, but I have retained the
> > split between "things that apply to the Gru family" (rk3399-gru.dtsi) and
> > "things that apply to Kevin only" (rk3399-gru-kevin.dtsi).
> 
> do you plan on refreshing these patches against the current kernel and the 
> comments received at some point?

I've fixed up a few locally, but I haven't had the time to
retest/resend. I plan to do so eventually, but not soon.

Brian
