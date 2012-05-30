From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 30 May 2012 01:52:31 -0700
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <4FC5DFCF.1020606@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/29/2012 2:58 AM, Peter De Schrijver wrote:
> Add an extension API for clocks. This allows clocktypes to provide extensions
> for features which are uncommon and cannot be easily mapped onto normal clock
> framework concecpts. eg: resetting blocks, configuring clock phase etc.

This seems rather generic. Why not add more specific APIs/concepts like
clk_reset(), clk_set_phase(), etc.? If they don't map, maybe we should
make them map.

At the least it should be documented so that people know what it should
be used for.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
