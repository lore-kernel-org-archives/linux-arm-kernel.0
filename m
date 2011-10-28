From: olof@lixom.net (Olof Johansson)
Date: Fri, 28 Oct 2011 02:19:56 -0700
Subject: [PATCH 2/6] arm/tegra: prepare pinmux code for multiple tegra
	variants
In-Reply-To: <20111028081738.GA12383@tbergstrom-lnx.Nvidia.com>
References: <1319561644-6160-1-git-send-email-pdeschrijver@nvidia.com>
	<1319561644-6160-3-git-send-email-pdeschrijver@nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173E1B49AA@HQMAIL01.nvidia.com>
	<20111028081738.GA12383@tbergstrom-lnx.Nvidia.com>
Message-ID: <CAOesGMi4NgYXUf8HtFM_=YX1aGnHbj2Wh8Wq7w=y17=Z21dqjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2011 at 1:17 AM, Peter De Schrijver
<pdeschrijver@nvidia.com> wrote:
> On Thu, Oct 27, 2011 at 09:59:49PM +0200, Stephen Warren wrote:

> Hmm. Maybe if I split it in 2 patches? 2 rename and 1 modification?

Yep, please do renames separately (you can rename all of them in one
patch, but no modifications in that please, besides what you need to
build with the new filename).


-Olof
